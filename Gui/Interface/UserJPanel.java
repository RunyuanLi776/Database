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
public class UserJPanel extends javax.swing.JPanel {

    /**
     * Creates new form EntitiesJPanel
     */
    public UserJPanel(JDBC jdbc,ArrayList<Object[]> users) {
       initComponents();
       System.out.println(users.size());
       populate(users);
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
        userTbl = new javax.swing.JTable();

        userTbl.setBackground(new java.awt.Color(51, 51, 51));
        userTbl.setFont(new java.awt.Font("Kai", 0, 14)); // NOI18N
        userTbl.setForeground(new java.awt.Color(255, 255, 255));
        userTbl.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "UserID", "UserName", "Email", "Address", "Password", "Purchaser", "Seller", "Administration"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class
            };
            boolean[] canEdit = new boolean [] {
                false, false, false, false, false, false, false, false
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        userTbl.setGridColor(new java.awt.Color(153, 153, 153));
        userTbl.setSelectionBackground(new java.awt.Color(153, 153, 153));
        userTbl.setSelectionForeground(new java.awt.Color(153, 153, 153));
        jScrollPane1.setViewportView(userTbl);
        if (userTbl.getColumnModel().getColumnCount() > 0) {
            userTbl.getColumnModel().getColumn(0).setResizable(false);
            userTbl.getColumnModel().getColumn(1).setResizable(false);
            userTbl.getColumnModel().getColumn(2).setResizable(false);
            userTbl.getColumnModel().getColumn(3).setResizable(false);
            userTbl.getColumnModel().getColumn(4).setResizable(false);
            userTbl.getColumnModel().getColumn(5).setResizable(false);
            userTbl.getColumnModel().getColumn(6).setResizable(false);
            userTbl.getColumnModel().getColumn(7).setResizable(false);
        }

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 900, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jScrollPane1, javax.swing.GroupLayout.Alignment.TRAILING)
        );
    }// </editor-fold>//GEN-END:initComponents


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTable userTbl;
    // End of variables declaration//GEN-END:variables

    private void populate(ArrayList<Object[]> users) {
        DefaultTableModel model = (DefaultTableModel)userTbl.getModel();
        model.setRowCount(0);
        
        for(Object[] user:users){
            Object[] row = new Object[8];
            for(int j = 0;j<8;j++) row[j] = user[j];
            model.addRow(row);
        }
        
    }
}
