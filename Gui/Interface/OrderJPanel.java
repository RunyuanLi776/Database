/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import Business.JDBC;
import java.util.ArrayList;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author lenovo
 */
public class OrderJPanel extends javax.swing.JPanel {

    /**
     * Creates new form OrderJPanel
     */
    private JDBC jbdc;
    public OrderJPanel(JDBC jdbc,ArrayList<Object[]> orders) {
       initComponents();
       this.jbdc = jbdc;
       System.out.println(orders.size());
       populate(orders);
    }
    
        private void populate(ArrayList<Object[]> orders) {
        DefaultTableModel model = (DefaultTableModel)orderTbl.getModel();
        model.setRowCount(0);
        
        for(Object[] order:orders){
            Object[] row = new Object[6];
            for(int j = 0;j<6;j++) row[j] = order[j];
            model.addRow(row);
        }
        
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane1 = new javax.swing.JScrollPane();
        orderTbl = new javax.swing.JTable();

        jScrollPane1.setBackground(new java.awt.Color(51, 51, 51));

        orderTbl.setBackground(new java.awt.Color(51, 51, 51));
        orderTbl.setFont(new java.awt.Font("Ink Free", 0, 14)); // NOI18N
        orderTbl.setForeground(new java.awt.Color(255, 255, 255));
        orderTbl.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "OrderID", "PurchaserID", "ProductID", "Date", "Status", "Price"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class
            };
            boolean[] canEdit = new boolean [] {
                false, false, false, false, false, false
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        orderTbl.setGridColor(new java.awt.Color(51, 51, 51));
        orderTbl.setSelectionBackground(new java.awt.Color(51, 51, 51));
        orderTbl.setSelectionForeground(new java.awt.Color(51, 51, 51));
        jScrollPane1.setViewportView(orderTbl);
        if (orderTbl.getColumnModel().getColumnCount() > 0) {
            orderTbl.getColumnModel().getColumn(0).setResizable(false);
            orderTbl.getColumnModel().getColumn(1).setResizable(false);
            orderTbl.getColumnModel().getColumn(2).setResizable(false);
            orderTbl.getColumnModel().getColumn(3).setResizable(false);
            orderTbl.getColumnModel().getColumn(4).setResizable(false);
            orderTbl.getColumnModel().getColumn(5).setResizable(false);
        }

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jScrollPane1, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, 900, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 600, Short.MAX_VALUE)
        );
    }// </editor-fold>//GEN-END:initComponents


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTable orderTbl;
    // End of variables declaration//GEN-END:variables
}
